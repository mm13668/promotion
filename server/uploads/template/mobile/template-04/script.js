var pendingReply = { answerId: '', content: '', el: null };

document.addEventListener('DOMContentLoaded', function() {
    localStorage.removeItem('user_token');
    localStorage.removeItem('user_phone');
});

function showReplyInput(el) {
    var card = el.closest('.ldy-answer-card');
    var wrap = card.querySelector('.ldy-reply-wrap');
    var hidden = wrap.style.display === 'none';
    document.querySelectorAll('.ldy-reply-wrap').forEach(function(w) { w.style.display = 'none'; });
    if (hidden) { wrap.style.display = 'block'; wrap.querySelector('textarea').focus(); }
}

async function publishReply(el) {
    var wrap = el.closest('.ldy-reply-wrap');
    var content = wrap.querySelector('textarea').value.trim();
    if (!content) { showToast('请输入回复内容', 'warning'); return; }
    var card = el.closest('.ldy-answer-card');
    pendingReply = { answerId: card.id || '', content: content, el: el };
    var token = localStorage.getItem('user_token');
    if (token) { await submitReply(); } else { showLoginModal(); }
    wrap.style.display = 'none';
    wrap.querySelector('textarea').value = '';
}

function showLoginModal() { document.getElementById('loginModal').classList.remove('hidden'); }
function closeLoginModal() {
    document.getElementById('loginModal').classList.add('hidden');
    document.getElementById('loginPhone').value = '';
    document.getElementById('loginPwd').value = '';
}

async function handleRegister() {
    var phone = document.getElementById('loginPhone').value.trim();
    var btn = document.querySelector('.ldy-btn-primary');
    if (!/^1[3-9]\d{9}$/.test(phone)) { showToast('请输入正确的手机号', 'error'); return; }
    var orig = btn.innerHTML;
    btn.innerHTML = '<span class="loading"></span>提交中...'; btn.disabled = true;
    try {
        await fetch('/api/promotion/landingPhone/create', {
            method: 'POST', headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, phone: phone, landingVisitId: window.LANDING_VISIT_ID ? Number(window.LANDING_VISIT_ID) : undefined })
        });
        localStorage.setItem('user_token', 'mock_token_' + Date.now());
        localStorage.setItem('user_phone', phone);
        showToast('提交成功', 'success');
        closeLoginModal();
        if (pendingReply.content) await submitReply();
    } catch(e) { showToast('网络错误', 'error'); }
    finally { btn.innerHTML = orig; btn.disabled = false; }
}

async function handleLogin() {
    var phone = document.getElementById('loginPhone').value.trim();
    var btn = document.querySelector('.ldy-btn-primary');
    if (!/^1[3-9]\d{9}$/.test(phone)) { showToast('请输入正确的手机号', 'error'); return; }
    var orig = btn.innerHTML;
    btn.innerHTML = '<span class="loading"></span>提交中...'; btn.disabled = true;
    try {
        await fetch('/api/promotion/landingPhone/create', {
            method: 'POST', headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, phone: phone, landingVisitId: window.LANDING_VISIT_ID ? Number(window.LANDING_VISIT_ID) : undefined })
        });
        localStorage.setItem('user_token', 'mock_token_' + Date.now());
        localStorage.setItem('user_phone', phone);
        showToast('提交成功', 'success');
        closeLoginModal();
        if (pendingReply.content) await submitReply();
    } catch(e) { showToast('网络错误', 'error'); }
    finally { btn.innerHTML = orig; btn.disabled = false; }
}

async function submitReply() {
    var btn = pendingReply.el.closest('.ldy-reply-wrap').querySelector('.ldy-reply-submit');
    var orig = btn.innerHTML;
    if (!localStorage.getItem('user_token') || !pendingReply.content) return;
    btn.innerHTML = '<span class="loading"></span>发布中...'; btn.disabled = true;
    try {
        await fetch('/api/promotion/landingMessage/create', {
            method: 'POST', headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ linkId: window.LINK_ID, content: pendingReply.content, phone: localStorage.getItem('user_phone') || '', landingVisitId: window.LANDING_VISIT_ID ? Number(window.LANDING_VISIT_ID) : undefined })
        });
        showToast('回复发布成功', 'success');
        pendingReply = { answerId: '', content: '', el: null };
    } catch(e) { showToast('网络错误', 'error'); }
    finally { btn.innerHTML = orig; btn.disabled = false; }
}

function showToast(msg, type) {
    var t = document.querySelector('.toast');
    if (t) t.remove();
    var d = document.createElement('div');
    d.className = 'toast ' + (type || 'success');
    d.textContent = msg;
    document.body.appendChild(d);
    setTimeout(function() { d.remove(); }, 2000);
}
