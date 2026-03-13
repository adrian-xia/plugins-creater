use anyhow::{Context, Result};
use clap::{Parser, Subcommand};
use std::fs;
use std::path::PathBuf;

#[derive(Parser)]
#[command(name = "codex-switch")]
#[command(about = "Switch between different codex authentication configurations")]
struct Cli {
    #[command(subcommand)]
    command: Option<Commands>,

    /// Source name to switch to (e.g., official)
    source: Option<String>,
}

#[derive(Subcommand)]
enum Commands {
    /// Register a new source
    Register {
        /// Name of the source to register
        name: String,
    },
    /// List all available sources
    List,
    /// Install shell completions
    Install {
        /// Shell type (bash, zsh, fish)
        #[arg(default_value = "zsh")]
        shell: String,
    },
}

fn get_codex_dir() -> Result<PathBuf> {
    let home = dirs::home_dir().context("Could not find home directory")?;
    Ok(home.join(".codex"))
}

fn get_auth_dir() -> Result<PathBuf> {
    Ok(get_codex_dir()?.join("auth"))
}

fn list_sources() -> Result<Vec<String>> {
    let auth_dir = get_auth_dir()?;

    if !auth_dir.exists() {
        return Ok(vec![]);
    }

    let mut sources = vec![];
    for entry in fs::read_dir(&auth_dir)? {
        let entry = entry?;
        if entry.path().is_dir() {
            if let Some(name) = entry.file_name().to_str() {
                sources.push(name.to_string());
            }
        }
    }

    sources.sort();
    Ok(sources)
}

fn switch_source(source: &str) -> Result<()> {
    let codex_dir = get_codex_dir()?;
    let auth_dir = get_auth_dir()?;
    let source_dir = auth_dir.join(source);

    if !source_dir.exists() {
        anyhow::bail!("Source '{}' not found. Available sources: {:?}", source, list_sources()?);
    }

    // Copy auth.json if exists
    let source_auth_json = source_dir.join("auth.json");
    let target_auth_json = codex_dir.join("auth.json");

    if source_auth_json.exists() {
        fs::copy(&source_auth_json, &target_auth_json)
            .context("Failed to copy auth.json")?;
        println!("✓ Copied auth.json");
    }

    // Copy config.toml if exists
    let source_config_toml = source_dir.join("config.toml");
    let target_config_toml = codex_dir.join("config.toml");

    if source_config_toml.exists() {
        fs::copy(&source_config_toml, &target_config_toml)
            .context("Failed to copy config.toml")?;
        println!("✓ Copied config.toml");
    }

    println!("✓ Switched to source: {}", source);
    Ok(())
}

fn register_source(name: &str) -> Result<()> {
    let auth_dir = get_auth_dir()?;
    let source_dir = auth_dir.join(name);

    if source_dir.exists() {
        println!("Source '{}' already exists", name);
        return Ok(());
    }

    fs::create_dir_all(&source_dir)
        .context("Failed to create source directory")?;

    println!("✓ Registered source: {}", name);
    println!("  Directory: {}", source_dir.display());
    println!("  Place your auth.json and/or config.toml in this directory");

    Ok(())
}

fn install_completions(shell: &str) -> Result<()> {
    let completion_script = match shell {
        "zsh" => generate_zsh_completion(),
        "bash" => generate_bash_completion(),
        "fish" => generate_fish_completion(),
        _ => anyhow::bail!("Unsupported shell: {}", shell),
    };

    println!("{}", completion_script);
    println!("\n# Add the above to your shell configuration file");

    Ok(())
}

fn generate_zsh_completion() -> String {
    r#"# Add this to your ~/.zshrc
_codex_switch_completions() {
    local -a sources
    if [[ -d ~/.codex/auth ]]; then
        sources=(${(f)"$(ls -1 ~/.codex/auth 2>/dev/null)"})
    fi
    sources+=(official)
    _describe 'source' sources
}

compdef _codex_switch_completions codex-switch"#.to_string()
}

fn generate_bash_completion() -> String {
    r#"# Add this to your ~/.bashrc
_codex_switch_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local sources=""
    if [[ -d ~/.codex/auth ]]; then
        sources=$(ls -1 ~/.codex/auth 2>/dev/null)
    fi
    sources="$sources official"
    COMPREPLY=($(compgen -W "$sources" -- "$cur"))
}

complete -F _codex_switch_completions codex-switch"#.to_string()
}

fn generate_fish_completion() -> String {
    r#"# Add this to ~/.config/fish/completions/codex-switch.fish
complete -c codex-switch -f
complete -c codex-switch -a "(ls ~/.codex/auth 2>/dev/null; echo official)"
"#.to_string()
}

fn main() -> Result<()> {
    let cli = Cli::parse();

    match cli.command {
        Some(Commands::Register { name }) => {
            register_source(&name)?;
        }
        Some(Commands::List) => {
            let sources = list_sources()?;
            if sources.is_empty() {
                println!("No sources registered yet");
                println!("Use 'codex-switch register <name>' to register a source");
            } else {
                println!("Available sources:");
                for source in sources {
                    println!("  - {}", source);
                }
            }
        }
        Some(Commands::Install { shell }) => {
            install_completions(&shell)?;
        }
        None => {
            if let Some(source) = cli.source {
                switch_source(&source)?;
            } else {
                println!("Usage: codex-switch <source>");
                println!("       codex-switch register <name>");
                println!("       codex-switch list");
                println!("       codex-switch install [shell]");
            }
        }
    }

    Ok(())
}
