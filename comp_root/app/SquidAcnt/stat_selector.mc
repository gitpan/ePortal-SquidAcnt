%#============================================================================
%# ePortal - WEB Based daily organizer
%# Author - S.Rusakov <rusakov_sa@users.sourceforge.net>
%#
%# Copyright (c) 2000-2003 Sergey Rusakov.  All rights reserved.
%# This program is free software; you can redistribute it
%# and/or modify it under the same terms as Perl itself.
%#
%#----------------------------------------------------------------------------
<%perl>
  my %args = $m->request_args;
  my $ss_period = $args{ss_period};

    # --------------------------------------------------------------------
    # Construct SQL Where clause
    #
  if ( $ss_period eq 'today' ) {
    $session{_SquidAcnt_where} = 'log_date >= curdate()';

  } elsif ( $ss_period eq 'week' ) {
    $session{_SquidAcnt_where} = 'log_date >= subdate(now(), interval 7 day)';

  } elsif ( $ss_period eq 'month' ) {
    $session{_SquidAcnt_where} = 'log_date >= date_format(curdate(), "%Y-%m-01")';

  } elsif ( $ss_period eq 'monthago' ) {
    $session{_SquidAcnt_where} =
      'log_date >= date_format(subdate(curdate(), interval 1 month), "%Y-%m-01")
      AND log_date < date_format(curdate(), "%Y-%m-01")';

  } else { # 2 hours
    $session{_SquidAcnt_where} = 'log_date >= subdate(now(), interval 2 hour)';
  }

</%perl>

<&| /dialog.mc:edit_dialog,
      title => pick_lang(rus => "����� ������", eng => 'Lookup criteria'),
      width => "350",
      focus => undef,
      method => "POST" &>

<& /dialog.mc:field, name => 'ss_period',
          fieldtype => 'popup_menu',
          label => {rus => '������', eng => 'Period'},
          value => $ss_period,
          values => [qw/hour today week month monthago/],
          labels => {
            hour     => {rus => '�� ��������� 2 ����', eng => 'Last 2 hours'},
            today    => {rus => '�� ����������� ����', eng => 'Today'},
            week     => {rus => '�� ��� ������', eng => 'This week'},
            month    => {rus => '�� ���� �����', eng => 'This month'},
            monthago => {rus => '�� ���������� �����', eng => 'Month ago'},
          },  &>

<& /dialog.mc:buttons, ok_label => pick_lang(rus => "������!", eng => "Search!"),
                      cancel_button => 0 &>
</&>
