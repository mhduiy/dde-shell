// Copyright (C) 2011 ~ 2018 Deepin Technology Co., Ltd.
// SPDX-FileCopyrightText: 2018 - 2023 UnionTech Software Technology Co., Ltd.
// SPDX-FileCopyrightText: 2023 UnionTech Software Technology Co., Ltd.
//
// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-License-Identifier: LGPL-3.0-or-later

#pragma once

#include "dsglobal.h"

#include <QtCore>
#include <QQmlEngine>
#include <DGuiApplicationHelper>

namespace dock {

Q_NAMESPACE
QML_NAMED_ELEMENT(Dock)

// dock keep 10:36:10
enum SIZE {
    MIN_DOCK_SIZE = 37,
    DEFAULT_DOCK_SIZE = 56,
    MAX_DOCK_SIZE = 100,
    MIN_DOCK_TASKMANAGER_ICON_SIZE = 24,
    MAX_DOCK_TASKMANAGER_ICON_SIZE = 64
};

enum IndicatorStyle {
    Fashion     = 0,
    Efficient   = 1,
};

enum ItemAlignment {
    CenterAlignment      = 0,
    LeftAlignment        = 1,
};

enum ColorTheme {
    Light = Dtk::Gui::DGuiApplicationHelper::ColorType::LightType,
    Dark  = Dtk::Gui::DGuiApplicationHelper::ColorType::DarkType,
};

enum HideMode {
    KeepShowing     = 0,
    KeepHidden      = 1,
    SmartHide       = 2
};

enum Position {
    Top     = 0,
    Right   = 1,
    Bottom  = 2,
    Left    = 3,
};

enum HideState {
    Unknown     = 0,
    Show        = 1,
    Hide        = 2,
};

enum AniAction {
    AA_Show = 0,
    AA_Hide
};

Q_ENUM_NS(SIZE)
Q_ENUM_NS(IndicatorStyle)
Q_ENUM_NS(ItemAlignment)
Q_ENUM_NS(ColorTheme)
Q_ENUM_NS(HideMode)
Q_ENUM_NS(Position)
Q_ENUM_NS(HideState)
Q_ENUM_NS(AniAction)
}

Q_DECLARE_METATYPE(dock::SIZE)
Q_DECLARE_METATYPE(dock::IndicatorStyle)
Q_DECLARE_METATYPE(dock::ItemAlignment)
Q_DECLARE_METATYPE(dock::ColorTheme)
Q_DECLARE_METATYPE(dock::HideMode)
Q_DECLARE_METATYPE(dock::HideState)
Q_DECLARE_METATYPE(dock::AniAction)
Q_DECLARE_METATYPE(dock::Position)

