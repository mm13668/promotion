package config

type Local struct {
	Path             string `mapstructure:"path" json:"path" yaml:"path"`                                           // 本地文件访问路径
	StorePath        string `mapstructure:"store-path" json:"store-path" yaml:"store-path"`                         // 本地文件存储路径
	TemplateBasePath string `mapstructure:"template-base-path" json:"template-base-path" yaml:"template-base-path"` // 模板存储路径
	PluginBasePath   string `mapstructure:"plugin-base-path" json:"plugin-base-path" yaml:"plugin-base-path"`       // 插件存储路径
	DistBasePath     string `mapstructure:"dist-base-path" json:"dist-base-path" yaml:"dist-base-path"`             // 生成页面存储路径
}
