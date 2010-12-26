ActiveRecord::Schema.define(:version => 0) do

  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
  end

  create_table :links, :force => true do |t|
    t.string :title
    t.string :url
  end


end