require 'spec_helper'
describe 'mymodule' do
  context 'with default values for all parameters' do
    it { should contain_class('mymodule') }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to have_resource_count(2) }
    it { is_expected.to have_file_resource_count(1) }
  end

  #context 'with gen_error => true' do
  #  let(:params) { {:gen_error => "Die, module!"} }

  #  it do
  #    expect {
  #      is_expected.to compile
  #    }.to raise_error(Puppet::Error, /MYMODULE/)
  #  end
  #end
end
