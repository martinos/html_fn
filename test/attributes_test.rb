require "test_helper"

require "html_fn/attributes"

class AttributesTest < Minitest::Test
  include HtmlFn::Attributes

  def test_that_it_has_a_version_number
    refute_nil ::HtmlFn::VERSION
  end

  def test_merge_attrs
    attrs = merge_attrs.([[:class, "col1 row1"], [:class, "col2 row2"]])
    assert_equal(%{class="col1 row1 col2 row2"}, attrs_to_s.(attrs))
  end

  def test_string_property
    assert_equal %{class="row"}, attrs_to_s.([string_property.(:class).("row")])
  end

  def test_merge_same_property
    assert_equal %{class="row col"}, attrs_to_s.([class_.("row"), class_.("col")])
  end

  def test_style_attrs
    assert_equal %{style="color: red; background-color: blue;"},
                 attrs_to_s.([style.([["color", "red"], ["background-color", "blue"]])])
  end
end
