%#============================================================================
%# ePortal - WEB Based daily organizer
%# Author - S.Rusakov <rusakov_sa@users.sourceforge.net>
%#
%# Copyright (c) 2000-2003 Sergey Rusakov.  All rights reserved.
%# This program is free software; you can redistribute it
%# and/or modify it under the same terms as Perl itself.
%#
%#
%#----------------------------------------------------------------------------
<%perl>
  my %args = $m->request_args;
  my $app = $ePortal->Application('SquidAcnt');

#
#=== Default navigator ======================================================
#

my %NAV = (
  title => 'Squid Accounting',
  description => pick_lang(rus => "���������� ����� ���������� ������-������� squid", eng => "Squid proxy server accounting application"),
  url => '/app/SquidAcnt/index.htm',
  items => [ qw/statistics setup/ ],

  statistics => {
    title => pick_lang(rus => "����������", eng => "Statistics"),
    description => pick_lang(rus => "���� ����������� ����������", eng => "Statistics menu"),
    items => [ qw/ by_group by_user by_domain /],
    disabled => ! $app->xacl_check_read,
  },  
  setup => {
    title => pick_lang(rus => "���������", eng => "Setup"),
    description => pick_lang(rus => "���� ���������", eng => "Setup menu"),
    items => [ qw/ user_list group_list block_group/],
    disabled => ! $app->xacl_check_update,
  },  

  by_group => {
    title => pick_lang(rus => "�� �������", eng => "By groups"),
    description => pick_lang(rus => "���������� �� ������� �������������", eng => "Groups of users statistics"),
    url => '/app/SquidAcnt/stat_groups.htm',
    disabled => ! $app->xacl_check_read,
  },
  by_user => {
    title => pick_lang(rus => "�� �������������", eng => "By users"),
    description => pick_lang(rus => "���������� �� �������������", eng => "Users statistics"),
    url => '/app/SquidAcnt/stat_users.htm',
    disabled => ! $app->xacl_check_read,
  },
  by_domain => {
    title => pick_lang(rus => "�� �������", eng => "By domains"),
    description => pick_lang(rus => "���������� �� ������� ���������", eng => "Internet domains statistics"),
    url => '/app/SquidAcnt/stat_domains.htm',
    disabled => ! $app->xacl_check_read,
  },

  user_list => {
    title => pick_lang(rus => "������������", eng => "Users"),
    description => pick_lang(rus => "������ �������������", eng => "List of users"),
    url => '/app/SquidAcnt/user_list.htm',
    disabled => ! $app->xacl_check_read,
  },
  group_list => {
    title => pick_lang(rus => "������", eng => "Groups"),
    description => pick_lang(rus => "������ ����� �������������", eng => "List of groups of users"),
    url => '/app/SquidAcnt/group_list.htm',
    disabled => ! $app->xacl_check_read,
  },
  block_group => {
    title => pick_lang(rus => "������ ����������", eng => "Blocking groups"),
    url => '/app/SquidAcnt/url_group_list.htm',
  },  
  %ARGS);
</%perl>

% if ($app->xacl_check_read) {
<& /navigator.mc, %NAV &>
% }
