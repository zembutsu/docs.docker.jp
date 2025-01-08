
// code-block 内で <語句> の時にスタイルと変更する

document.addEventListener('DOMContentLoaded', function() {
    // code-block 内のテキストを探して置換
    document.querySelectorAll('.highlight').forEach(function(block) {
        const content = block.innerHTML;
        block.innerHTML = content.replace(
            /&lt;(\w+)&gt;/g,  // <語句> のパターンにマッチ
            '<span class="param">$1</span>'  // span で置換
        );
    });
});
