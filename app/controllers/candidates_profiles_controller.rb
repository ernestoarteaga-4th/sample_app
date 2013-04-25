class CandidatesProfilesController < ApplicationController
  # GET /candidates_profiles
  # GET /candidates_profiles.json
  def index
    @candidates_profiles = CandidatesProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @candidates_profiles }
    end
  end

  # GET /candidates_profiles/1
  # GET /candidates_profiles/1.json
  def show
    @candidates_profile = CandidatesProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @candidates_profile }
    end
  end

  # GET /candidates_profiles/new
  # GET /candidates_profiles/new.json
  def new
    @candidates_profile = CandidatesProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @candidates_profile }
    end
  end

  # GET /candidates_profiles/1/edit
  def edit
    @candidates_profile = CandidatesProfile.find(params[:id])
  end

  # POST /candidates_profiles
  # POST /candidates_profiles.json
  def create
    @candidates_profile = CandidatesProfile.new(params[:candidates_profile])

    respond_to do |format|
      if @candidates_profile.save
        format.html { redirect_to @candidates_profile, notice: 'Candidates profile was successfully created.' }
        format.json { render json: @candidates_profile, status: :created, location: @candidates_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @candidates_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /candidates_profiles/1
  # PUT /candidates_profiles/1.json
  def update
    @candidates_profile = CandidatesProfile.find(params[:id])

    respond_to do |format|
      if @candidates_profile.update_attributes(params[:candidates_profile])
        format.html { redirect_to @candidates_profile, notice: 'Candidates profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @candidates_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates_profiles/1
  # DELETE /candidates_profiles/1.json
  def destroy
    @candidates_profile = CandidatesProfile.find(params[:id])
    @candidates_profile.destroy

    respond_to do |format|
      format.html { redirect_to candidates_profiles_url }
      format.json { head :no_content }
    end
  end
end
