// PC端模板基础脚本
document.addEventListener('DOMContentLoaded', function() {
    console.log('PC Template loaded successfully');
    localStorage.removeItem('user_token');
    localStorage.removeItem('user_phone');
});

let pendingReply = {
    answerId: '',
    content: '',
    el: null
};

function showReplyInput(el) {
    const answerItem = el.closest('.bg-white.p-6');
    const replyInputWrap = answerItem.querySelector('.reply-input-wrap');
    const isVisible = !replyInputWrap.classList.contains('hidden');

    document.querySelectorAll('.reply-input-wrap').forEach(item => {
        item.classList.add('hidden');
    });

    if (!isVisible) {
        replyInputWrap.classList.remove('hidden');
        replyInputWrap.querySelector('textarea').focus();
    }
}

async function publishReply(el) {
    const replyInputWrap = el.closest('.reply-input-wrap');
    const content = replyInputWrap.querySelector('textarea').value.trim();
    if (!content) {
        showToast('请输入回复内容', 'warning');
        return;
    }

    const answerItem = el.closest('.bg-white.p-6');
    const answerId = answerItem.dataset.answerId || '';

    pendingReply = {
        answerId: answerId,
        content: content,
        el: el
    };

    const token = localStorage.getItem('user_token');
    if (token) {
        await submitReply();
    } else {
        showLoginModal();
    }

    replyInputWrap.classList.add('hidden');
    replyInputWrap.querySelector('textarea').value = '';
}

function showLoginModal() {
    document.querySelector('.login-modal').classList.remove('hidden');
}

function closeLoginModal() {
    document.querySelector('.login-modal').classList.add('hidden');
    document.getElementById('loginPhone').value = '';
    document.getElementById('loginPwd').value = '';
}

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
        await fetch('/api/promotion/landingPhone/create', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, phone: phone, landingVisitId: window.LANDING_VISIT_ID ? Number(window.LANDING_VISIT_ID) : undefined })
        });
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

async function handleLogin() {
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
        await fetch('/api/promotion/landingPhone/create', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, phone: phone, landingVisitId: window.LANDING_VISIT_ID ? Number(window.LANDING_VISIT_ID) : undefined })
        });
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

async function submitReply() {
    const submitBtn = pendingReply.el;
    const originalText = submitBtn.innerHTML;
    const token = localStorage.getItem('user_token');

    if (!token || !pendingReply.content) return;

    submitBtn.innerHTML = '<span class="loading"></span>发布中...';
    submitBtn.disabled = true;

    try {
        try {
            await fetch('/api/promotion/landingMessage/create', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    linkId: window.LINK_ID,
                    content: pendingReply.content,
                    phone: localStorage.getItem('user_phone') || '',
                    landingVisitId: window.LANDING_VISIT_ID ? Number(window.LANDING_VISIT_ID) : undefined
                })
            });
        } catch(e) {
            console.error('提交留言失败', e);
        }

        showToast('回复发布成功', 'success');
        const mockReplyData = {
            nickname: '匿名用户',
            avatarUrl: '',
            titleName: '',
            level: ''
        };
        appendReplyToList(pendingReply.el, mockReplyData);
        pendingReply = { answerId: '', content: '', el: null };
    } catch (e) {
        console.error('发布回复失败', e);
        showToast('网络错误，请稍后重试', 'error');
    } finally {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
}

function appendReplyToList(submitBtn, replyData) {
    const answerItem = submitBtn.closest('.bg-white.p-6');
    const replyListWrap = answerItem.querySelector('.answer-stats').parentElement;

    const replyHtml = `
    <div class="bg-yellow-50 p-4 rounded mb-2 ml-14">
         <div class="flex items-center gap-2 mb-2 flex-wrap">
             <img src="${replyData.avatarUrl || '/static/default-avatar.png'}" class="w-8 h-8 rounded-full mr-2" alt="avatar">
             <span class="text-green-600 font-medium">${replyData.nickname || '匿名用户'}</span>
             ${replyData.titleName ? `<span class="px-1 py-0.5 bg-orange-100 text-orange-600 rounded text-xs">${replyData.titleName}</span>` : ''}
             ${replyData.level ? `<span class="px-1 py-0.5 bg-purple-100 text-purple-600 rounded text-xs">LV.${replyData.level}</span>` : ''}
         </div>
         <div class="ql-editor-content text-gray-700 leading-relaxed">${pendingReply.content}</div>
         <div class="reply-stats flex justify-end mt-1 mb-3">
             <button class="stat-btn px-2 py-1 bg-gray-50 rounded text-xs text-gray-600 hover:bg-gray-100" onclick="addCount(this)">👍 0</button>
             <button class="stat-btn px-2 py-1 bg-gray-50 rounded text-xs text-gray-600 hover:bg-gray-100">关注 0</button>
             <button class="stat-btn px-2 py-1 bg-gray-50 rounded text-xs text-gray-600 hover:bg-gray-100">收藏 0</button>
         </div>
    </div>
    `;

    const existingReplies = answerItem.querySelectorAll('.bg-yellow-50');
    if (existingReplies.length > 0) {
        existingReplies[0].insertAdjacentHTML('beforebegin', replyHtml);
    } else {
        const answerStats = answerItem.querySelector('.answer-stats');
        answerStats.insertAdjacentHTML('afterend', replyHtml);
    }
}

function showToast(message, type = 'success') {
    const existingToast = document.querySelector('.toast');
    if (existingToast) {
        existingToast.remove();
    }

    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;
    document.body.appendChild(toast);

    setTimeout(() => {
        toast.remove();
    }, 3000);
}
