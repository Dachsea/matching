require "csv"

CSV.foreach('db/member_data.csv', encoding: "Shift_JIS:UTF-8") do |row|
  Member.create(name: row[0], working_flg: row[1])
  puts "#{row[0]},#{row[1]}"
end