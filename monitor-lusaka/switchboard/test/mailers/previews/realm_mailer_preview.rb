# Preview all emails at http://localhost:3000/rails/mailers/national_operator_mailer

class RealmMailerPreview < ActionMailer::Preview
  def new_realm_institutional
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'created').institutional
  end  
  def new_realm_national
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'created').national
  end  
  def new_realm_regional
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'created').regional
  end  

  def updated_realm_institutional
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'updated').institutional
  end
  def updated_realm_national
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'updated').national
  end
  def updated_realm_regional
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'updated').regional
  end

  def deleted_realm_institutional
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'deleted').institutional
  end
  def deleted_realm_national
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'deleted').national
  end
  def deleted_realm_regional
    RealmMailer.with(realm: Realm.first, organisation: Organisation.first, action: 'deleted').regional
  end

end
