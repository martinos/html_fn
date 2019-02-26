require "test_helper"

class HtmlFnTest < Minitest::Test
  include HtmlFn
  A = HtmlFn::Attributes

  def setup
    # HtmlFn::Attributes.name.("viewport")
    @bulma = div.([]).([
      node.(:meta).([A.name.("viewport"),
                     A.content.("width=device-width, initial-scale=1")]).([]),
      node.(:link).([A.rel.("stylesheet"),
                     A.href.("https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css")]).([]),
    ])
  end

  def test_that_it_has_a_version_number
    refute_nil ::HtmlFn::VERSION
  end

  def test_node
    assert_kind_of String, node.("h1").([]).([])
  end

  def test_complex
    my_table = div.([]).(
      [@bulma,
       table.([A.class_.("table")]).(
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
      )]
    )

    expected = <<EOF
<div>
  <div>
    <meta name='viewport' content='width=device-width, initial-scale=1'/>
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css'/>
  </div>
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
</div>
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
