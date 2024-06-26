require("luasnip.session.snippet_collection").clear_snippets("sql")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("sql", {
  s(
    "select",
    fmt(
      [[
      SELECT
        {}
      FROM
        {}
      WHERE
        1 = 1
        AND {}
      ORDER BY
        {}
      ]],
      { i(1, "*"), i(2, "table"), i(3, "condition"), i(4, "col") }
    )
  ),
  s(
    "join",
    fmt(
      [[
  {} JOIN {}
  ON {} = {}
  ]],
      { i(1, "INNER"), i(2, "table t2"), i(3, "t1.col"), i(4, "t2.col") }
    )
  ),
  s(
    "cte",
    fmt(
      [[
  {} AS (
    SELECT
      {}
    FROM
      {}
    WHERE
      1 = 1
      AND {}
    GROUP BY
      {}
  )
  ]],
      { i(1, "WITH cte_name"), i(2, "*"), i(3, "table"), i(4, "condition"), i(5, "col") }
    )
  ),
})
