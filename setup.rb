require "mysql2"
require "active_record"
require 'date'

# ActiveRecord::Migration.create_table :students do |t|
#   t.string :name
#   t.integer :club_id
# end
#
# ActiveRecord::Migration.create_table :clubs do |t|
#   t.string :name
# end
#
# ActiveRecord::Migration.create_table :exams do |t|
#   t.string :name
# end
#
# ActiveRecord::Migration.create_table :exams_subjects do |t|
#   t.integer :exam_id
#   t.integer :subject_id
# end
#
# ActiveRecord::Migration.create_table :subjects do |t|
#   t.string :name
# end
#
# ActiveRecord::Migration.create_table :exam_scores do |t|
#   t.string :title
#   t.integer :students_id
#   t.integer :subject_id
# end
#
# ActiveRecord::Migration.create_table :subjects do |t|
#   t.string :name
# end



`echo 'drop database sql_drill' | mysql -uroot`
`echo 'create database sql_drill' | mysql -uroot`
config = {
  user: :root,
  password: "",
  :adapter   => "mysql2",
  :encoding  => "utf8",
  :reconnect => true,
  :pool      => 5,
  :database  => 'sql_drill'
}
ActiveRecord::Base.establish_connection(config)

ActiveRecord::Migration.create_table :students do |t|
  t.string :name
  t.boolean :active, defult: true
  t.integer :club_id
end

ActiveRecord::Migration.create_table :clubs do |t|
  t.string :name
end

ActiveRecord::Migration.create_table :club_reports do |t|
  t.date :reported_on
  t.integer :score
  t.integer :student_id
  t.integer :club_id
end


class Student < ActiveRecord::Base
  belongs_to :club
end

class Club < ActiveRecord::Base
  has_one :student
  has_many :club_reports
end

class ClubReport < ActiveRecord::Base
  belongs_to :student
  belongs_to :clud
end

pingpon_culb = Club.create(name: '卓球部')
punter_culb = Club.create(name: '戦車道')

yamada = Student.create(name: 'yamada', club: punter_culb)
takebe = Student.create(name: 'takebe', club: punter_culb)
ratta = Student.create(name: 'ratta', club: pingpon_culb)
miho = Student.create(name: 'miporin', club: nil, active: false)

takebe.club.club_reports.create(reported_on: Date.new(2011, 1, 1), score: 20)
takebe.club.club_reports.create(reported_on: Date.new(2011, 1, 2), score: 20)
takebe.club.club_reports.create(reported_on: Date.new(2011, 1, 3), score: 20)
takebe.club.club_reports.create(reported_on: Date.new(2011, 2, 3), score: 20)
takebe.club.club_reports.create(reported_on: Date.new(2011, 2, 4), score: 20)
takebe.club.club_reports.create(reported_on: Date.new(2012, 3, 3), score: 20)
takebe.club.club_reports.create(reported_on: Date.new(2012, 3, 4), score: 20)
