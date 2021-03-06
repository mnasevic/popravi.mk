class WelcomeController < ApplicationController

  layout "welcome"

  def index
    @problems = Problem.ordered.includes([:category, :municipality]).limit(5)
    @municipalities = Municipality.order('problems_count DESC').limit(5)
    @post = Post.from_admins.published.ordered.first
    @problem = Problem.with_status('solved').order('solved_at DESC').first
  end

  def android
  end

end
