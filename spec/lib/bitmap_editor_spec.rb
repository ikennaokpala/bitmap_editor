require 'spec_helper'

describe BitmapEditor do
  describe "#run" do
    let(:no_file_path) { nil }
    let(:unavailable_file_path) { fixtures_file_path("unavailable.txt") }
    let(:empty_file_path) { fixtures_file_path("empty.txt") }
    let(:s_file_path) { fixtures_file_path("s.txt") }
    let(:arbitrary_file_path) { fixtures_file_path("arbitrary.txt") }

    context "when commands file does not exists" do
      it "returns incorrect output message if no file path is defined" do
        expect { subject.run(no_file_path) }.to(
          output(/please provide correct file/).to_stdout
        )
      end

      it "returns incorrect output message if unavailable file path is defined" do
        expect { subject.run(unavailable_file_path) }.to(
          output(/please provide correct file/).to_stdout
        )
      end
    end

    context "when commands file exists" do
      it "returns empty output if empty file is supplied" do
        expect { subject.run(empty_file_path) }.to output("").to_stdout
      end

      it "returns no image output if file with only 'S' command is supplied" do
        expect { subject.run(s_file_path) }.to output(/There is no image/).to_stdout
      end

      it "returns unrecognised output if file with an unrecognised command is supplied" do
        expect { subject.run(arbitrary_file_path) }.to(
          output(/unrecognised command :\(/).to_stdout
        )
      end
    end
  end
end
