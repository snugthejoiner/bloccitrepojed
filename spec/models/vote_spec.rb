describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        expect(@vote.value.abs).to eq(1) #I assume 1 and -1 are not boolean values but actual integers
      end
    end
  end
end