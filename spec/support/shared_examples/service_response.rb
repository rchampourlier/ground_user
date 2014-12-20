shared_examples 'ServiceResponse' do |expected_status, expected_data, expected_errors|

  it 'should return a ServiceResponse' do
    expect(subject).to be_a GroundUser::ServiceResponse
  end

  describe 'returned ServiceResponse' do

    describe 'status' do
      it "should be #{expected_status}" do
        expect(subject.status).to eq(expected_status)
      end
    end

    describe 'data' do

      if expected_data.is_a?(Hash)
        expected_klass = expected_data.keys.first
        expected_values = expected_data[expected_klass]

        it "should be a #{expected_klass}" do
          expect(subject.data).to be_a expected_klass
        end

        expected_values.each do |attribute, value|
          describe "#{attribute}" do
            it "should be #{value}" do
              expect(subject.data.send(attribute)).to eq(value)
            end
          end
        end

      else
        it "should be #{expected_data}" do
          expect(subject.data).to eq expected_data
        end
      end
    end

    describe 'errors' do
      it "should be #{expected_errors}" do
        expect(subject.errors).to eq(expected_errors)
      end
    end
  end
end
