package callback

import (
	"fmt"
	"sync"
)

var (
	defaultFactory     *CallbackFactory
	defaultFactoryOnce sync.Once
)

// CallbackFactory 回传提供者工厂
type CallbackFactory struct {
	mu        sync.RWMutex
	providers map[string]CallbackProvider
}

// NewCallbackFactory 创建新的工厂实例
func NewCallbackFactory() *CallbackFactory {
	return &CallbackFactory{
		providers: make(map[string]CallbackProvider),
	}
}

// Register 注册一个回传提供者
func (f *CallbackFactory) Register(provider CallbackProvider) {
	f.mu.Lock()
	defer f.mu.Unlock()
	f.providers[provider.Name()] = provider
}

// GetProvider 获取指定名称的回传提供者
func (f *CallbackFactory) GetProvider(name string) (CallbackProvider, error) {
	f.mu.RLock()
	defer f.mu.RUnlock()
	p, ok := f.providers[name]
	if !ok {
		return nil, fmt.Errorf("callback provider '%s' not registered", name)
	}
	return p, nil
}

// GetDefaultFactory 获取默认全局工厂
func GetDefaultFactory() *CallbackFactory {
	defaultFactoryOnce.Do(func() {
		defaultFactory = NewCallbackFactory()
		// 默认注册百度OCPC和巨量引擎（其余通过各文件 init 自注册）
		defaultFactory.Register(NewBaiduProvider())
		defaultFactory.Register(NewOceanEngineProvider())
	})
	return defaultFactory
}
