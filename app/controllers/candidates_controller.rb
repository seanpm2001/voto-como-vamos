# encoding: utf-8
class CandidatesController < ApplicationController
  before_filter :load_candidate, :except => [:index]
  before_filter :authorize_candidate, :only => [:edit, :update]

  def index
    @candidates = if params[:query].present?
      Candidate.search(params[:query], :load => true)
    else
      Candidate.all
    end
  end

  def show
  end

  def edit
  end

  def update
    if @candidate.update_attributes(params[:candidate])
      redirect_to candidate_path(@candidate.id), 
        :notice => "Perfil atualizado com sucesso"
    else
      render :edit
    end
  end

  private

  def authorize_candidate
    unless current_user.represents? @candidate
      redirect_to root_path
    end
  end

  def load_candidate
    @candidate = Candidate.find(params[:id])
  end
end
