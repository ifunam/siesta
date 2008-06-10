require File.dirname(__FILE__) + '/../test_helper'
class UserTest < Test::Unit::TestCase
  fixtures :userstatuses, :users

  def setup
    @logins = User.find(:all).collect { |u|  u.login }
    @attributes = %w( login passwd email userstatus_id )
  end

  def test_authenticate?
    assert User.authenticate?('admin','maltiempo')
    assert User.authenticate?('alejandro','maltiempo')
    assert User.authenticate?('alex.juarez','maltiempo')
  end

  def test_should_not_authenticate?
    assert !User.authenticate?('admin','badpassword')
    assert !User.authenticate?('alejandro','morebadpassword')
    assert !User.authenticate?('alex.juarez','moremorebadpassword')
  end

  def test_should_authenticate_by_token?
    assert User.authenticate_by_token?('alex.juarez','lcGVrs2FmS')
    assert !User.authenticate_by_token?('admin','badtoken')
    assert !User.authenticate_by_token?('alejandro','badtoken')
  end

  def test_should_change_password
    assert User.change_password('admin','maltiempo', 'new_password')
    assert User.change_password('alejandro','maltiempo', 'uno_nuevo')
    assert User.change_password('alex.juarez','maltiempo', 'el exxxxxx')
  end

  def test_should_encrypt_string
    assert_equal '285915705af70616553eb13a997ee9f5183d3a83b9c9a36c6a928dc64920c664f8c5eb5284643d7edd2edcb6c4948af68f6322d98991cf61f104bced3bf50028', User.encrypt('somepassword', 'RhKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG')
  end

  def test_should_activate_user
    for login in (@logins)
      @user = User.find_by_login(login)
      @user.activate
      assert @user.is_activated?
    end
  end

  def test_should_lock_user
    for login in (@logins)
      @user = User.find_by_login(login)
      @user.lock
      assert @user.is_locked?
    end
  end

  def test_should_send_user_to_history_file
    for login in (@logins)
      @user = User.find_by_login(login)
      @user.send_to_history_file
      assert @user.is_in_history_file?
    end
  end

  def test_should_get_new_token
    for login in (%w(alejandro admin))
      @user = User.find_by_login(login)
      assert @user.token.empty?
      @user.new_token
      assert !@user.token.empty?
    end
  end

  def test_should_destroy_token
    @user = User.find_by_login('alex.juarez')
    assert !@user.token.empty?
    @user.destroy_token
    assert @user.token.nil?
  end

  def test_new_user_should_be_unactivated
    @user = User.build_valid(:login => 'john', :passwd => 'supersecret', :email => 'john@somedomain.com')
    assert @user.valid?
    @user.save
    assert @user.is_unactivated?
  end

  def test_new_user_should_be_created
    assert_difference 'User.count' do
      user = User.build_valid
      deny user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_validates_presence_of_them_all
    record = User.new
    [:login, :email, :passwd].each do |field|
      assert_validates_presence_of(record,field)
    end
  end

  def test_validates_length_of_login
    record = User.build_valid(:login => "al")
    assert_validates_on_message(record, :login, "is too short")

    record = User.build_valid(:login => "al" * 16)
    assert_validates_on_message(record, :login, "is too long")
  end

  def test_validates_length_of_email
    record = User.build_valid(:email => "a@s.c")
    assert_validates_on_message(record, :email, "is too short")

    record = User.build_valid(:email => 'user@'+'domain' * 16 + '.com')
    assert_validates_on_message(record, :email, "is too long")
  end

  def test_validates_length_of_passwd
    record = User.new(:passwd => "abcd")
    assert_validates_on_message(record, :passwd, "is too short")
    record = User.new(:passwd => 's' * 201 )
    assert_validates_on_message(record, :passwd, "is too long")
  end

  def test_validates_format_of_email
    record = User.build_valid(:email => "nil")
    assert_validates_on_message(record, :email, "is too short")

    record = User.build_valid(:email => 'user@'+'d@main.com')
    assert_validates_on_message(record, :email, "is invalid")

    record = User.build_valid(:email => 'user.'+'dmain.com')
    assert_validates_on_message(record, :email, "is invalid")
  end


  def test_validates_format_of_login
    record = User.build_valid(:login => '@user@')
    assert_validates_on_message(record, :login, "is invalid")
    # FIXIT: Check for valid login string
    #    record = User.build_valid(:login => '------')
    #    assert_validates_on_message(record, :login, "is invalid")

    #    record = User.build_valid(:login => '__')
    #    assert_validates_on_message(record, :login, "is invalid")

    #    record = User.build_valid(:login => '..')
    #    assert_validates_on_message(record, :login, "is invalid")
  end

  def test_uniqueness_of_login_and_email
    record = User.build_valid
    assert record.save
    record = User.build_valid
    assert_validates_on_message(record, :login, "has already been taken")
  end

  def test_unactivated_users
    record = User.build_valid
    record.save
    assert_equal 1, User.unactivated.count
  end

  def test_activated_users
    assert_equal 3, User.activated.count
  end

  def test_locked_users
    usersc=%w(admin alejandro)
    users.each do |user|
      User.find_by_login(user).lock
    end
    assert_equal users.size, User.locked.count
  end

  def test_users_in_history_file
      usersc=%w(admin alejandro)
      users.each do |user|
            User.find_by_login(user).send_to_history_file
      end
    assert_equal users.size, User.in_history_file.count
  end

  def test_users_with_user_incharge
    record = User.build_valid
    record.user_incharge = User.find_by_login('admin')
    record.save
    assert_equal 1, User.with_user_incharge.count
  end

  private
  def assert_validates_presence_of(record, field)
    assert_validates_on_message(record, field, "can't be blank")
  end

  def assert_validates_on_message(record, field, message)
    assert !record.valid?
    assert record.errors.on(field)
    assert_match /#{message}/, record.errors.on(field).to_s
  end
end
