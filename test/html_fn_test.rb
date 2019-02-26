require "test_helper"

class HtmlFnTest < Minitest::Test
  include HtmlFn
  include HtmlFn::Attributes

  def test_that_it_has_a_version_number
    refute_nil ::HtmlFn::VERSION
  end

  def test_node
    assert_kind_of String, node.("h1").([]).([])
  end

  def test_complex
    my_table = table.([class_.("table")]).(
      [thead.([]).(
        [tr.([]).(
          [th.([]).([text.("Name")]),
           th.([]).([text.("Age")])]
        )]

      ),
       tbody.([]).(
        [tr.([]).([
          td.([]).([text.("Martin")]),
          td.([]).([text.("34")]),
        ])]
      )]
    )

    expected = <<EOF
<table class='table'>
  <thead>
    <tr>
      <th>
        Name
      </th>
      <th>
        Age
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        Martin
      </td>
      <td>
        34
      </td>
    </tr>
  </tbody>
</table>
EOF

    assert_equal expected.strip, pretty_print(my_table)
  end

  def pretty_print(a)
    require "rexml/document"
    d = REXML::Document.new(a)
    d.write(s = "", 2)
    s
  end
end
