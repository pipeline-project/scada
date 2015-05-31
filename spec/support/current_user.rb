module ControllerHelpers
  def sign_in(user = create(:user))
    if user.nil?
      sign_in_without_user
    else
      sign_in_user(user)
    end
  end

  private

  def sign_in_without_user
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
    allow(controller).to receive(:current_user).and_return(nil)
  end

  def sign_in_user(user)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
