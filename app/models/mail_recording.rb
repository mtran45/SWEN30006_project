class MailRecording < ActiveRecord::Base
	validates_uniqueness_of :articlename, scope: :email
end
