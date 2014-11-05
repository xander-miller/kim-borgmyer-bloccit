require 'rails_helper'

describe Vote do

  describe "validations" do
    describe "value validation" do

      it "only allows -1 or 1 as values" do

        vote = Vote.new( value: 1 )
        expect( vote.valid? ).to eq( true )

        vote2 = Vote.new( value: -1 )
        expect( vote2.valid? ).to eq( true )

        vote3 = Vote.new( value: 2 )
        expect( vote3.valid? ).to eq( false )
        
      end

    end
  end

  describe 'after_save' do
    it "calls 'Post#update_rank' after save" do
      post = create( :post )
      vote = Vote.new( value: 1, post: post )
      expect( post ).to receive( :update_rank )
      vote.save
    end
  end

end
