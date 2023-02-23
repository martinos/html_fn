require "html_fn/version"
require "fn_reader"
require "html_fn/attributes"

module HtmlFn
  fn_reader :node, :div, :table, :thead, :tr, :th, :td, :tbody, :text
  @@node = ->tag, attrs, elems {
    <<EOF
<#{tag} #{Attributes.attrs_to_s.(attrs)}>#{elems.join("\n")}</#{tag}>
EOF
  }.curry

  @@text = ->a { [a.to_s] }

  @@script = node.(:script)
  @@table = node.(:table)
  @@thead = node.(:thead)
  @@tr = node.(:tr)
  @@th = node.(:th)
  @@td = node.(:td)
  @@tbody = node.(:tbody)
  @@div = node.(:div)
end
