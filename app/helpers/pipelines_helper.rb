module PipelinesHelper
  def render_step(step)
    render step
  rescue ActionView::MissingTemplate
    render partial: 'steps/step', locals: { step: step }
  end
end
