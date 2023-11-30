Admin.create!(
  email: 'admin@admin',
  password: 'adminadmin',
)
Genre.create!([
  {
    name: "def"
  },
  {
    name: "abc"
  },
  {
    name: "ghi"
  }
  ])

Item.create!([
  {
  genre_id: 1,
  name: "aaa",
  description: "bbb",
  price_before_tax: 123,
  is_active: true,
  },
  {
  genre_id: 2,
  name: "ccc",
  description: "ddd",
  price_before_tax: 456,
  is_active: false,
  }
  ])
