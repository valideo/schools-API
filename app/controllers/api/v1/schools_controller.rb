class Api::V1::SchoolsController < Api::ApiController

  #GET REQUEST 
  #Retourne liste de toutes les écoles avec possibilité de filtrer public ou private
  def index
    @schools = School.filter(params)
  end

  # POST REQUEST
  #
  #Crée nouvelle école avec les parmètres entrés
  #
  # @retourne 401 si OK
  # @422 si erreur
  #
  def create
    @school = School.create(school_params)

    if @school.errors.any?
      render json: { success: false, errors: @school.errors.messages }, status: 422
    else
      render template: 'api/v1/schools/show', status: 201
    end
  end

  # DELETE REQUEST
  #
  # Supprime une école 
  # Id de l'écoele en paramètre
  #
  # @retourn 201 si OK
  # @retourne 422 si Erreur
  #
  def destroy
    @school = School.destroy(params[:id])

    if @school.errors.any?
      render json: { success: false, errors: @school.errors.messages }, status: 422
    else
      render json: { success: true, message: 'Delete Success' }, status: 201
    end
  end

  private

  # Valeurs d'une école
  #
  def school_params
    params.require(:school).permit(
      :name,
      :address,
      :city,
      :zip_code,
      :latitude,
      :longitude,
      :status,
      :students_count,
      :opening_hours,
      :email,
      :phone
    )
  end
end
