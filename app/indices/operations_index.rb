ThinkingSphinx::Index.define :operation, with: :active_record do
  indexes status, sortable: true
  indexes kind, sortable: true
  indexes invoice_num, sortable: true
  indexes reporter, sortable: true

  has company_id,created_at, updated_at
end

