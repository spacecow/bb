require 'spec_helper'

describe 'familiars/_new.html.erb' do
  let(:familiar){ mock_model(Familiar).as_new_record }
  before{ render 'familiars/new', familiar:familiar }

  subject{ rendered }
  it{ should have_selector 'h2', text:'New Familiar' }
  it{ should have_selector 'form.new_familiar' }
end
