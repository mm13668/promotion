// 模板基础脚本
let showAllContent = false;

document.addEventListener('DOMContentLoaded', function() {
    // 检查内容是否溢出
    setTimeout(checkContentOverflow, 0);
    console.log('Template loaded successfully');
});

function checkContentOverflow() {
    const el = document.querySelector('.ql-editor-content');
    if (el) {
        const lineHeight = parseFloat(getComputedStyle(el).lineHeight) || 24;
        const maxHeight = lineHeight * 5;
        if (el.scrollHeight > maxHeight) {
            el.classList.add('line-clamp-5');
            document.getElementById('showMoreBtn').style.display = 'block';
        }
    }
}

function toggleContent() {
    const el = document.querySelector('.ql-editor-content');
    const btn = document.getElementById('showMoreBtn').querySelector('span');
    showAllContent = !showAllContent;
    if (showAllContent) {
        el.classList.remove('line-clamp-5');
        btn.textContent = '收起';
    } else {
        el.classList.add('line-clamp-5');
        btn.textContent = '显示全部';
    }
}