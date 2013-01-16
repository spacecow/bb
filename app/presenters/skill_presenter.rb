class SkillPresenter < BasePresenter
  presents :skill

  def description
    s = skill.description
    h.content_tag :div, class:'description' do
      "Description: #{s}" unless s.blank?
    end
  end

  def note
    s = skill.note
    h.content_tag :div, class:'note' do
      "Note: #{s}" unless s.blank?
    end
  end

  def familiars
    h.content_tag :div, class:'familiars' do
      h.render 'familiars/familiars', familiars:skill.familiars, sort:'name'
    end
  end
end
