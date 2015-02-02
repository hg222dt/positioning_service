class User < ActiveRecord::Base
	validates 	:email, :presence => {:message => "Du måste ange ett förnamn"}, 
				:length => {:minimum => 2, :message => "Ange minst 2 tecken"}
end
