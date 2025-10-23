Name: onavim
Version: 0.0.1
Release: 1%{?dist}
Summary: Whimsical vim

License: MIT
URL: https://github.com/JanKXSKI/onavim
Source0: %{name}-%{version}.tar.gz

Requires: bash >= 4.1 vim >= 9.1 epel-release fzf bat the_silver_searcher nc bc npm

%description
More or less vim

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
cp onavim $RPM_BUILD_ROOT/%{_bindir}

wget https://github.com/wfxr/code-minimap/releases/download/v0.6.8/code-minimap-v0.6.8-x86_64-unknown-linux-gnu.tar.gz
tar -zxvf code-minimap-v0.6.8-x86_64-unknown-linux-gnu.tar.gz
cp code-minimap-v0.6.8-x86_64-unknown-linux-gnu/code-minimap $RPM_BUILD_ROOT/%{_bindir}/onavim-code-minimap
rm -rf code-minimap-v0.6.8-x86_64-unknown-linux-gnu
rm -f code-minimap-v0.6.8-x86_64-unknown-linux-gnu.tar.gz

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/onavim
%{_bindir}/onavim-code-minimap
%license LICENSE

%changelog
* Thu Oct 23 2025 Jan Klimaschewski <Jan.Klimaschewski@profidata.com>
- init
