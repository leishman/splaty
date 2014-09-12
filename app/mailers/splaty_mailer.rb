class SplatyMailer < ActionMailer::Base
  default from: "no-reply@splaty.com"

  def wall_copy(wall, email)
  	@wall = wall
  	mail(to: email, subject: "Copy of Splaty - #{wall.path}")
  end
end
