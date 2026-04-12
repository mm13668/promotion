// 登录模态框控制
function closeLoginModal() {
    const modal = document.getElementById('loginModal');
    if (modal) {
        modal.classList.add('hidden');
    }
}

function handleLogin() {
    const phone = document.getElementById('loginPhone').value;
    const pwd = document.getElementById('loginPwd').value;

    if (!phone || !pwd) {
        alert('请输入手机号和密码');
        return;
    }

    // 这里添加登录逻辑
    console.log('登录:', phone, pwd);
    alert('登录功能待实现');
}

function handleRegister() {
    const phone = document.getElementById('loginPhone').value;
    const pwd = document.getElementById('loginPwd').value;

    if (!phone || !pwd) {
        alert('请输入手机号和密码');
        return;
    }

    // 这里添加注册逻辑
    console.log('注册:', phone, pwd);
    alert('注册功能待实现');
}

// 显示回复输入框
function showReplyInput(btn) {
    const answerCard = btn.closest('.answer-card');
    const replyInputWrap = answerCard.querySelector('.reply-input-wrap');

    if (replyInputWrap) {
        replyInputWrap.classList.toggle('hidden');
    }
}

// 发布回复
function publishReply(btn) {
    const replyInputWrap = btn.closest('.reply-input-wrap');
    const textarea = replyInputWrap.querySelector('.reply-textarea');
    const content = textarea.value.trim();

    if (!content) {
        alert('请输入回复内容');
        return;
    }

    // 这里添加发布回复逻辑
    console.log('发布回复:', content);
    alert('回复功能待实现');

    // 清空输入框
    textarea.value = '';
    replyInputWrap.classList.add('hidden');
}

// 点击模态框背景关闭
document.addEventListener('click', function(e) {
    const modal = document.getElementById('loginModal');
    if (modal && !modal.classList.contains('hidden')) {
        if (e.target === modal) {
            closeLoginModal();
        }
    }
});

// 防止页面滚动穿透（当模态框打开时）
function preventScroll() {
    const modal = document.getElementById('loginModal');
    if (modal && !modal.classList.contains('hidden')) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
}

// 监听模态框显示状态
const observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {
        if (mutation.attributeName === 'class') {
            preventScroll();
        }
    });
});

const modal = document.getElementById('loginModal');
if (modal) {
    observer.observe(modal, { attributes: true });
}
