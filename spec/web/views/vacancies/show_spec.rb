# frozen_string_literal: true

RSpec.describe Web::Views::Vacancies::Show, type: :view do
  let(:exposures) { { format: :html, vacancy: vacancy_aggregate, flash: {} } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/vacancies/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:vacancy_aggregate) do
    Vacancy.new(
      contact: Contact.new(created_at: Time.now),
      position: 'Ruby vacancy',
      created_at: Time.now
    )
  end

  it { expect(rendered).to match('Ruby vacancy') }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end

  it 'social buttons showing' do
    expect(rendered).to match('<div class="likely likely-small">')
  end

  it 'when head does contain style likely link' do
    expect(rendered).to match('<link href="/assets/likely.css" type="text/css" rel="stylesheet">')
  end
  it 'when app does contain js likely link' do
    expect(rendered).to match('<script src="/assets/likely.js" type="text/javascript"></script>')
  end
end
