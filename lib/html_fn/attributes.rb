
module HtmlFn
  module Attributes
    fn_reader :merge_attrs, :attrs_to_s, :string_property,
      :class_, :style, :name, :content, :href, :rel

    # Your code goes here...
    # module HtmlFnc
    @@merge_attrs = -> hash {
      hash.inject({}) do |group, (key, values)|
        group[key] ||= []
        group[key] += [values]
        group
      end.map { |key, val| [key, val.join(" ")] }.to_h
    }

    @@attrs_to_s = -> attrs {
      merged = @@merge_attrs.(attrs)
      merged.map do |(attr_name, values)|
        %{#{attr_name}="#{values}"}
      end.join(" ")
    }

    @@string_property = -> name, string {
      [name, string]
    }.curry

    @@style = -> styles {
      string_property.("style").
        (styles.map { |(key, val)| %{#{key}: #{val};} }.join(" "))
    }

    @@class_ = string_property.(:class)
    @@id_ = string_property.(:id)
    @@name = string_property.(:name)
    @@content = string_property.(:content)
    @@href = string_property.(:href)
    @@rel = string_property.(:rel)
  end
end
