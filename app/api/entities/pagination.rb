# frozen_string_literal: true

class Entities::Pagination < Grape::Entity
  root "pagination", "pagination"
  expose :pages, documentation: { type: "Integer", desc: "Total pages." }
  expose :next, documentation: { type: "String", desc: "Next page." }
  expose :prev, documentation: { type: "String", desc: "Previous page" }
  expose :page, documentation: { type: "Integer", desc: "Current Page." }
  expose :count, documentation: { type: "Integer", desc: "Total number." }
end
