class FieldDiariesController < ApplicationController
  before_action :authenticate_user!, only: [:sync]
  before_action :set_user, only: [:sync]

  # GET /field_diaries
  def index
    @field_diaries = FieldDiary.all

    render json: @field_diaries
  end

  # GET /field_diaries/1
  def show
    render json: @field_diary
  end

  # POST /field_diaries
  def create
    @field_diary = FieldDiary.new(field_diary_params)

    if @field_diary.save
      render json: @field_diary, status: :created, location: @field_diary
    else
      render json: @field_diary.errors, status: :unprocessable_entity
    end
  end

  def sync
    #current_user

    array = params[:_json]

    array.each do |value|
      farming = Farming.find(value[:id])

      field_diary = FieldDiary.find_by(user_id: @user.id, farming_id: farming.id)

      if field_diary.blank?
        field_diary = FieldDiary.new(name: 'Diario de ' + @user.get_fullname + ": " + farming.name)
        field_diary.user = @user
        field_diary.farming = farming
        field_diary.save
      end
      body = value[:body]
      body.each do |note|
        puts "Id de la nota " + note[:id]
        findNote = Note.find_by(id: note[:id])
        if findNote.nil?
          puts 'GUARDA'
          newNote = Note.new
          newNote.id = note[:id]
          newNote.name = note[:title]
          newNote.body = note[:body]
          newNote.createdDate = note[:date]
          newNote.field_diary = field_diary
          newNote.save
        else
          if note[:deleted] == 0
            puts 'ACTUALIZA'
            findNote.name = note[:title]
            findNote.body = note[:body]
            findNote.save
          else
            puts 'BORRAR'
            findNote.destroy
          end
        end
      end      
    end

    @table = Note.joins(:field_diary).select(
      :id,
      'notes.name AS title',
      :body,
      :createdDate,
      'field_diaries.farming_id AS farming_id',
    )
    

    render json: @table
  end

  # PATCH/PUT /field_diaries/1
  def update
    if @field_diary.update(field_diary_params)
      render json: @field_diary
    else
      render json: @field_diary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /field_diaries/1
  def destroy
    @field_diary.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field_diary
      @field_diary = FieldDiary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def field_diary_params
      params.require(:field_diary).permit(:name)
    end

    def set_user
      @user = current_user
    end
end
