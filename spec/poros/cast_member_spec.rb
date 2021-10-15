require "rails_helper"

RSpec.describe CastMember do

  it 'can have basic attributes' do
    data = {
            name: "Morgan Freeman",
            character: 'Narrator'
        }
    member = CastMember.new(data)

    expect(member.name).to eq("Morgan Freeman")
    expect(member.character).to eq("Narrator")
  end
end
