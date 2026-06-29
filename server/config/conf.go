package config

type Conf struct {
	MainDomain  string `mapstructure:"main-domain" json:"main-domain" yaml:"main-domain"`
	LdyDomain   string `mapstructure:"ldy-domain" json:"ldy-domain" yaml:"ldy-domain"`
	CnameDomain string `mapstructure:"cname-domain" json:"cname-domain" yaml:"cname-domain"`
	NewsDomain  string `mapstructure:"news-domain" json:"news-domain" yaml:"news-domain"`
}
