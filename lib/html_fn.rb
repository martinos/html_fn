require "html_fn/version"
require "fn_reader"
require "html_fn/attributes"

module HtmlFn
  fn_reader :tag, :table, :thead, :tr, :th, :td, :tbody, :text, :headers, :row, :html_table,
    :node, :table, :thead, :th, :td, :th, :tbody

  @@node = -> tag, attrs, elems {
    <<EOF
<#{tag} #{Attributes.attrs_to_s.(attrs)}>#{elems.join("\n")}</#{tag}>
EOF
  }.curry

  @@script = node.(:script)
  @@table = node.(:table)
  @@thead = node.(:thead)
  @@tr = node.(:tr)
  @@th = node.(:th)
  @@td = node.(:td)
  @@tbody = node.(:tbody)
  @@text = -> a { [a.to_s] }
end
