import { registerPlugin } from '@capacitor/core';

import type { ApplePayPlugin } from './definitions';

const FreshaApplePay = registerPlugin<ApplePayPlugin>('FreshaApplePay', {
  web: () => import('./web').then(m => new m.ApplePayWeb()),
});

export * from './definitions';
export { FreshaApplePay };
