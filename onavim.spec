Name: onavim
Version: 0.0.1
Release: 1%{?dist}
Summary: Whimsical vim

License: MIT
URL: https://github.com/JanKXSKI/onavim
Source0: %{name}-%{version}.tar.gz

Requires: bash >= 4.1 epel-release fzf bat the_silver_searcher nc bc gawk sed clangd

%description
More or less vim

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/opt/onavim/%{version}/bin
mkdir -p $RPM_BUILD_ROOT/opt/onavim/%{version}/etc

cat >$RPM_BUILD_ROOT/%{_bindir}/onavim <<EOF
#! /usr/bin/env bash
/opt/onavim/%{version}/sh/onavim  "$@"
EOF

wget https://github.com/wfxr/code-minimap/releases/download/v0.6.8/code-minimap-v0.6.8-x86_64-unknown-linux-gnu.tar.gz
tar -zxvf code-minimap-v0.6.8-x86_64-unknown-linux-gnu.tar.gz
cp code-minimap-v0.6.8-x86_64-unknown-linux-gnu/code-minimap \
    $RPM_BUILD_ROOT/opt/onavim/%{version}/bin/code-minimap
rm -rf code-minimap-v0.6.8-x86_64-unknown-linux-gnu
rm -f code-minimap-v0.6.8-x86_64-unknown-linux-gnu.tar.gz

[[ rpm -q ncurses-devel ]] || sudo dnf install ncurses-devel
./vim.sh $RPM_BUILD_ROOT /opt/onavim/%{version}

[[ rpm -q npm ]] || sudo dnf install npm
./npm.sh $RPM_BUILD_ROOT /opt/onavim/%{version}

cp src/etc/tmux.conf $RPM_BUILD_ROOT/opt/onavim/%{version}/etc/tmux.conf

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/onavim
/opt/onavim/%{version}
%license LICENSE

%changelog
* Thu Oct 23 2025 Jan Klimaschewski <Jan.Klimaschewski@profidata.com>
- init
