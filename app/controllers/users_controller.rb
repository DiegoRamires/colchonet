class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			Signup.confirm_email(@user).deliver

			redirect_to @user, notice: 'Cadastro criado com sucesso!'
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user,
				notice: 'Cadastro atualizado com sucesso!'
		else
			render action: :edit
		end
	end


	private

	def user_params
		#os pontos no final da linha nao sao opcionais
		params.
			require(:user).
			permit(:email, :full_name, :location, :password, :password_confirmation, :bio)
	end
end
