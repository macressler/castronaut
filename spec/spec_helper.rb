require 'rubygems'

gem 'sqlite3-ruby'
gem 'rspec', '>= 1.2.4'
gem 'activerecord', '>= 2.1.0'

require File.join(File.dirname(__FILE__), '..', 'castronaut')
require File.join(File.dirname(__FILE__), 'spec_rails_mocks')

Castronaut.config = Castronaut::Configuration.load(File.join(File.dirname(__FILE__), '..', 'config', 'castronaut.example.yml'))

class CreateUsers < ActiveRecord::Migration
  Castronaut::Adapters::RestfulAuthentication::User.connection.create_table "users", :force => true do |t|
    t.column :login,                     :string, :limit => 40
    t.column :name,                      :string, :limit => 100, :default => '', :null => true
    t.column :email,                     :string, :limit => 100
    t.column :crypted_password,          :string, :limit => 40
    t.column :salt,                      :string, :limit => 40
    t.column :created_at,                :datetime
    t.column :updated_at,                :datetime
    t.column :remember_token,            :string, :limit => 40
    t.column :remember_token_expires_at, :datetime
    t.string :first_name, :last_name
  end
  Castronaut::Adapters::RestfulAuthentication::User.connection.add_index :users, :login, :unique => true
end

class CreateUsers < ActiveRecord::Migration
  Castronaut::Adapters::Development::User.connection.create_table "users", :force => true do |t|
    t.column :login,                     :string, :limit => 40
    t.column :name,                      :string, :limit => 100, :default => '', :null => true
    t.column :password,                  :string
  end
  Castronaut::Adapters::Development::User.connection.add_index :users, :login, :unique => true
end

Spec::Runner.configure do |config|
  config.include Spec::Rails::Mocks
end
