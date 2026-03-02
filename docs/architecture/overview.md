# 架构概览

项目按四层组织：

1. `config/` - 类型定义与默认配置
2. `templates/` - 生成工具所使用的源模板
3. `src/plugins_creater/` - 生成器逻辑与共享工具函数
4. `plugins/` - 实际生成出的插件产物

注册表元数据存放在 `registry/index.json`。
