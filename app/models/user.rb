# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  admin                        :boolean          default(FALSE)
#  email                        :string           default(""), not null
#  encrypted_password           :string           default(""), not null
#  first_name                   :string
#  last_name                    :string
#  notify_when_added_to_project :boolean          default(TRUE)
#  notify_when_task_completed   :boolean          default(TRUE)
#  notify_when_task_created     :boolean          default(TRUE)
#  remember_created_at          :datetime
#  reset_password_sent_at       :datetime
#  reset_password_token         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :project_users
  has_many :projects, through: :project_users
  has_many :projects, dependent: :destroy
  
  has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
