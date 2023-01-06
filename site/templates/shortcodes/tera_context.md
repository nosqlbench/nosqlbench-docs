<div title="tera_context" style="border: solid 1px;">
<span>tera_context:</span>
<link rel="stylesheet" href="/jsonpath-picker.min.css" />
<script type="text/javascript" src="/jsonpath-picker.min.js"></script>
{# from https://github.com/ryshu/jsonpath-picker #}

<div id="dests" type="text"></div>
<div id="treeview">
<input class="path" type="text">
<pre id="json-renderer"></pre>
</div>

<script type="text/javascript">
let data = {{ __tera_context | as_str }};
source = document.querySelector('#json-renderer');
dest = document.querySelectorAll('.path');
JPPicker.render(source, data, dest, {outputCollapsed:true});
document.querySelector("div#treeview a").click();

</script>
</div>
