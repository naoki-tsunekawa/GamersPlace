require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { FactoryBot.build(:game) }

  # 有効な掲示板を作成できるかどうかのテスト
  it 'it is a valid Game' do
    expect(game).to be_valid
  end

  # バリデーションテスト
  it 'is invalid with no title' do
    game.title = ' '
    expect(game).to be_invalid
  end

end
